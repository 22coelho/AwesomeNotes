package com.smith.micro.notes_api.service;

import com.smith.micro.notes_api.dao.NoteRepository;
import com.smith.micro.notes_api.dao.UserRepository;
import com.smith.micro.notes_api.entity.Note;
import com.smith.micro.notes_api.entity.User;
import com.smith.micro.notes_api.response.NoteResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Service
@RequiredArgsConstructor
public class NoteService {
    private final UserRepository userRepository;
    private final NoteRepository noteRepository;

    public List<NoteResponse> getAllNotesFromUsername(String username) {
        User user = userRepository.findByUsername(username).orElseThrow();

        List<Note> list = noteRepository.findByUser_Id(user.getId());
        List<NoteResponse> responseList = new ArrayList<>();
        for (Note note : list) {
            NoteResponse noteResponse = NoteResponse.builder()
                    .id(note.getId())
                    .title(note.getTitle())
                    .description(note.getDescription())
                    .createdAt(note.getCreatedAt())
                    .username(note.getUser().getUsername()).build();

            responseList.add(noteResponse);
        }

        return responseList;
    }

    public List<NoteResponse> getAllNotes() {

        List<Note> list = noteRepository.findAll();
        List<NoteResponse> responseList = new ArrayList<>();
        for (Note note : list) {
            NoteResponse noteResponse = NoteResponse.builder()
                    .id(note.getId())
                    .title(note.getTitle())
                    .description(note.getDescription())
                    .createdAt(note.getCreatedAt())
                    .username(note.getUser().getUsername()).build();

            responseList.add(noteResponse);
        }

        return responseList;
    }

    public NoteResponse addNote(String username, String description, String title) {
        User user = userRepository.findByUsername(username).orElseThrow();
        Note note = Note.builder()
                .title(title)
                .description(description)
                .user(user)
                .build();
        noteRepository.save(note);

        return NoteResponse.builder()
                .id(note.getId())
                .title(note.getTitle())
                .createdAt(note.getCreatedAt())
                .username(note.getUser().getUsername())
                .description(note.getDescription()).build();
    }

    public NoteResponse removeNote(String username, int noteId) {
        Note note = noteRepository.findByUsernameAndId(username, noteId).orElseThrow();

        noteRepository.delete(note);

        return NoteResponse.builder()
                .id(note.getId())
                .title(note.getTitle())
                .createdAt(note.getCreatedAt())
                .username(note.getUser().getUsername())
                .description(note.getDescription()).build();
    }
}
