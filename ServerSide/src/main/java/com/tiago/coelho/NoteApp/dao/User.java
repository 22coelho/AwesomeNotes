package com.tiago.coelho.NoteApp.dao;

public class User {

    private int id;
    private String username;
    private String email;

    public User() {}

    public User(String username, String email) {
        this.username = username;
        this.email = email;
    }
}
