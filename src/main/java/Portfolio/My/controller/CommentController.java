package Portfolio.My.controller;

import Portfolio.My.domain.CommentDto;
import Portfolio.My.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpSession;
import java.util.List;

// @Controller
// @ResponseBody
@RestController
public class CommentController {
    @Autowired
    CommentService service;

    // 댓글을 수정하는 메서드
    @PatchMapping("/comments/{cno}")
    public ResponseEntity<String> write(@PathVariable Integer cno, @RequestBody CommentDto dto, HttpSession session) {
        String commenter = (String)session.getAttribute("id");
        dto.setCommenter(commenter);
        dto.setCno(cno);
        System.out.println("dto = " + dto);

        try {
            if(service.modify(dto) != 1)
                throw new Exception("Modify failed.");

            return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("MOD_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    // 댓글을 등록하는 메서드
    @PostMapping("/comments")  // @RequestBody는 json을 자바 객체로 받는다는 뜻이다.
    public ResponseEntity<String> write(@RequestBody CommentDto dto, Integer bno, HttpSession session) {
        String commenter = (String)session.getAttribute("id");
        dto.setCommenter(commenter);
        dto.setBno(bno);

        try {
            if(service.write(dto) != 1)
                throw new Exception("Write failed.");

            return new ResponseEntity<>("WRT_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("WRT_ERR", HttpStatus.BAD_REQUEST);
        }
    }


    // 지정된 댓글을 삭제하는 메서드
    @DeleteMapping("/comments/{cno}")  // comments/1?bno=1085 <== 삭제할 댓글 번호  (REST 방식으로 설계된 uri)
    public ResponseEntity<String> remove(@PathVariable Integer cno, Integer bno, HttpSession session) {
        // 매핑된 url의 일부인 cno를 읽어오려면 앞에다가 @PathVariable 어노테이션을 붙여줘야 한다. 사용할때는 그냥 /comments/1 이렇게 사용하지만 값은 {}중괄호 안에 넣어 가져오고 어노테이션을 사용해준다.
        String commenter = (String)session.getAttribute("id");

        try {
            int rowCnt = service.remove(cno, bno, commenter);

            if(rowCnt != 1)
                throw new Exception("Delete Failed");

            return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("DEL_ERR", HttpStatus.BAD_REQUEST);
        }
    }


    @GetMapping("/comments") // comments?bno=1080   GET방식  이렇게 그냥 url뒤에 쿼리 스트링이 있으면 바로 파라미터에 bno를 쓸 수 있지만 위의 remove메서드처럼
                               // 쿼리스트링이 아닌 uri의 일부를 가져오려면 ex) {cno} 이렇게 되어있는것에는 @PathVarialbe을 꼭 써줘야 한다.
        public ResponseEntity<List<CommentDto>> list(Integer bno) {  // 앞에 @ResponseBody를 안붙여주면 아래 return값이 view이름으로 해석된다.
        List<CommentDto> list = null;
        try {
            list = service.getList(bno);
            return new ResponseEntity<List<CommentDto>>(list,HttpStatus.OK);  // ResponseEntity라는게 list가 entitiy인데 해당 entitiy에 뒤의 상태코드를 추가한 다는 뜻이다.
            // 이렇게 ResponseEntity를 해주지 않으면 오류가 발생하더라도 200 상태코드가 떠서 오류가 발생했는지 잘 모르기 때문에 설정해 주어야 한다.
            // Entity : 응답이나 요청할 때 전송할 대상을 뜻한다.
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<CommentDto>>(HttpStatus.BAD_REQUEST);  // ResponseEntity를 이용해 상황에 맞는 상태 코드를 띄울 수 있도록 한다.
        }
    }
}
