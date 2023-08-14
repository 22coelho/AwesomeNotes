package com.tiago.coelho.NoteApp.dao;

public class Note {

    private int id;
    private String description;
    private int user_id;

    public Note() {}

    public Note(String description, int user_id) {
        this.description = description;
        this.user_id = user_id;
    }
}
