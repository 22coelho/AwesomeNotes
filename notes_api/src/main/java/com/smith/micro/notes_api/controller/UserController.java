package com.smith.micro.notes_api.controller;

import com.smith.micro.notes_api.auth.AuthenticationResponse;
import com.smith.micro.notes_api.entity.User;
import com.smith.micro.notes_api.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/notes-api/users")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @PostMapping("/register")
    public ResponseEntity<AuthenticationResponse> register(@RequestParam String username, @RequestParam String password) {
        return ResponseEntity.ok(userService.register(username, password));
    }

    @PostMapping("/login")
    public ResponseEntity<AuthenticationResponse> authenticate(@RequestParam String username, @RequestParam String password) {
        return ResponseEntity.ok(userService.authenticate(username, password));
    }

    @PostMapping("/refresh-token")
    public void refreshToken(HttpServletRequest request, HttpServletResponse response) throws IOException {
        userService.refreshToken(request, response);
    }
}
