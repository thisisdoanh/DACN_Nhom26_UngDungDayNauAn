package com.chiendang.cooking.api.instruction.repository;

import com.chiendang.cooking.api.instruction.entity.Instruction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InstructionRepository extends JpaRepository<Instruction , Integer> {
}
