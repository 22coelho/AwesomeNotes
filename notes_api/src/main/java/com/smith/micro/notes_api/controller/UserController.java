package com.smith.micro.notes_api.controller;

import com.smith.micro.notes_api.entity.User;
import com.smith.micro.notes_api.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {
    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public ResponseEntity<List<User>> getAllPosts() {
        List<User> users = userService.getAllUsers();
        return ResponseEntity.ok(users);
    }


}
