package com.side.mvcshop;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller

public class MainController {
    @GetMapping("/")
    public String index() {

        System.out.println("main controller에서 루트 패스 실행됨");

        return "index.jsp";
    }
}
