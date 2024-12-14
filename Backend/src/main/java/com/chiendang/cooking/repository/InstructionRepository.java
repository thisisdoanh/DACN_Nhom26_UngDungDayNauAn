package com.chiendang.cooking.repository;

import com.chiendang.cooking.entity.Instruction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InstructionRepository extends JpaRepository<Instruction , Integer> {

    @Query(value = """
            Select * from instruction i
            where i.recipe_id = :id
            """,nativeQuery = true)
    List<Instruction> findAllByRecipeId(@Param("id")Integer id);
}
