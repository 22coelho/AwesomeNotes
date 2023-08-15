package com.smith.micro.notes_api.dao;

import com.smith.micro.notes_api.entity.Note;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.List;
import java.util.Optional;

@RepositoryRestResource
public interface NoteRepository extends JpaRepository<Note, Integer> {
    List<Note> findByUser_Id(int userId);

    @Query("SELECT n FROM Note n WHERE n.id = :id AND n.user.username = :username")
    Optional<Note> findByUsernameAndId(String username, int id);
}
