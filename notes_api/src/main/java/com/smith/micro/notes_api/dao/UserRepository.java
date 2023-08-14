package com.smith.micro.notes_api.dao;

import com.smith.micro.notes_api.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUsername(@Param("username") String username);


}
