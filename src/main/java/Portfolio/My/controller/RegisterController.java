package Portfolio.My.controller;

import Portfolio.My.domain.User;
import Portfolio.My.domain.UserValidator;
import Portfolio.My.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller // ctrl+shift+o 자동 import
@RequestMapping("/register")
public class RegisterController {
    @Autowired
    UserService userService;

    final int FAIL = 0;

    @InitBinder
    public void toDate(WebDataBinder binder) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(df, false));
        binder.setValidator(new UserValidator()); // UserValidator를 WebDataBinder의 로컬 validator로 등록
    }

    @GetMapping("/add")
    public String register() {
        return "registerForm";
    }

    @PostMapping("/add")
    public String save(@Valid User user, BindingResult result, Model m) {

        // User객체를 검증한 결과 에러가 있으면, registerForm을 이용해서 에러를 보여줘야 함.
        try {
            if(!result.hasErrors()) {
                // 2. DB에 신규회원 정보를 저장
                int rowCnt = userService.write(user);

                if(rowCnt!=FAIL) {
                    m.addAttribute("msg", "RST_OK");
                    return "registerInfo";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "RST_ERR");
        }
        return "registerForm";
    }

    private boolean isValid(User user) {
        return true;
    }
}