package com.smith.micro.notes_api.controller;

import com.smith.micro.notes_api.entity.Note;
import com.smith.micro.notes_api.response.NoteResponse;
import com.smith.micro.notes_api.service.NoteService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/notes-api/notes")
@RequiredArgsConstructor
public class NoteController {
    private final NoteService noteService;

    @GetMapping
    public ResponseEntity<List<NoteResponse>> getAllNotesFromUsername(@RequestParam String username) {
        return ResponseEntity.ok(noteService.getAllNotesFromUsername(username));
    }

    @GetMapping("/all")
    public ResponseEntity<List<NoteResponse>> getAllNotes() {
        return ResponseEntity.ok(noteService.getAllNotes());
    }

    @PostMapping("/add")
    public ResponseEntity<NoteResponse> addNote(@RequestParam String username, @RequestBody Map<String, String> requestBody) {
        String title = requestBody.get("title");
        String description = requestBody.get("description");

        return ResponseEntity.ok(noteService.addNote(username, description, title));
    }

    @DeleteMapping("/remove")
    public ResponseEntity<NoteResponse> removeNote(@RequestParam String username, @RequestParam int noteId) {
        return ResponseEntity.ok(noteService.removeNote(username, noteId));
    }
}
