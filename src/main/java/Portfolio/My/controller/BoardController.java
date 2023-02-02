package Portfolio.My.controller;

import Portfolio.My.domain.BoardDto;
import Portfolio.My.domain.PageHandler;
import Portfolio.My.domain.SearchCondition;
import Portfolio.My.service.BoardService;
import Portfolio.My.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    BoardService boardService;
    @Autowired
    CommentService commentService;

    @PostMapping("/remove")
    public String remove(Integer bno, Integer page, Integer pageSize, Model m, HttpSession session, RedirectAttributes rattr) {
        String writer = (String)session.getAttribute("id");
        try {
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
            // return하기전에 Model객체인 m.addAttribute로 값을 넣어주면 return값이 자동으로
            // return "redirect:/board/list?page=page&pageSize=pageSize; 이렇게 자동으로 뒤에 값이 들어간다.
            // 이렇게 값을 넣는 것이 POST매핑이고 나타내는 것이 get매핑이다.

           int rowCnt = boardService.remove(bno, writer);
           if(rowCnt != 1){
               throw new Exception("board remove error");
           }
            rattr.addFlashAttribute("msg", "DEL_OK");
        } catch (Exception e) {
            e.printStackTrace();
           // m.addAttribute("msg", "DEL_ERR"); <- 이런 에러 메시지가 한번만 뜨게 하려면 RedirectAttributes rattr <- 이걸 사용해 줘야 한다.
            rattr.addFlashAttribute("msg", "DEL_ERR"); // 이렇게 지정해 주면 된다.
            // 그리고 그 에러 메시지를 모델에 저장하면 계속 남아 있기 때문에 파라미터에서 지정한 rattr에 넣어주면 한번 사용한 후 없어진다.
        }
        return "redirect:/board/list";
    }
    @PostMapping("/modify")
    public String modify(BoardDto boardDto, Model m, HttpSession session, RedirectAttributes rattr) {
        String writer = (String)session.getAttribute("id");
        boardDto.setWriter(writer);

        try {
            int rowCnt = boardService.modify(boardDto);  // update

            if(rowCnt != 1)
                throw new Exception("Modify failed");


            rattr.addFlashAttribute("msg", "MOD_OK");
            return "redirect:/board/list";
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("boardDto", boardDto);
            m.addAttribute("msg", "MOD_ERR");

            return "board";
        }
    }

    @GetMapping("/write")
    public String write(Model m) {
        m.addAttribute("mode", "new");
        return "board";  // board.jsp를 읽기와 쓰기에 사용, 쓰기에 사용할때는 mode=new값을 넘겨준다.
    }

    @PostMapping("/write")
    public String write(BoardDto boardDto, Model m, HttpSession session, RedirectAttributes rattr) {
        String writer = (String)session.getAttribute("id");
        boardDto.setWriter(writer);

        try {
            if(boardService.write(boardDto) != 1)
                throw new Exception("Write failed");

            rattr.addFlashAttribute("msg", "WRT_OK");
            return "redirect:/board/list";
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("boardDto", boardDto);
            m.addAttribute("mode", "new");
            m.addAttribute("msg", "WRT_ERR");

            return "board";
        }
    }
    @GetMapping("/read")
    public String read(Integer bno, Integer page, Integer pageSize, Model m) {
        try {
            BoardDto boardDto = boardService.read(bno);
            // m.addAttribute("boardDto", boardDto); 아래의 내용과 같다.
            m.addAttribute(boardDto);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "board";
    }

    @GetMapping("/list")
    public String list(SearchCondition sc, Model m, HttpServletRequest request) { // 이 파라미터들 값 앞에는 자동적으로 @ModelAttribute가 붙는데 생략할 수 있다.
        if(!loginCheck(request))
            return "redirect:/login/login?toURL="+request.getRequestURL();  // 로그인을 안했으면 로그인 화면으로 이동

        try {
            int totalCnt = boardService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            List<BoardDto> list = boardService.getSearchResultPage(sc);
            m.addAttribute("list", list);  // model로 담은 이 list의 값은 boardList.jsp로 boardService.getPage(map)으로 가져온 데이터를 "list"로 담아 넘겨준다.
            m.addAttribute("ph", pageHandler);

            Instant startOfToday = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant();
            m.addAttribute("startOfToday", startOfToday.toEpochMilli());

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "LIST_ERR");
            m.addAttribute("totalCnt", 0);
        }

        return "boardList"; // 로그인을 한 상태이면, 게시판 화면으로 이동
    }

    private boolean loginCheck(HttpServletRequest request) {
        // 1. 세션을 얻어서(false는 session이 없어도 새로 생성하지 않는다. 반환값 null)
        HttpSession session = request.getSession(false);
        // 2. 세션에 id가 있는지 확인, 있으면 true를 반환
        return session!=null && session.getAttribute("id")!=null;
    }
}