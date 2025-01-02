package com.chiendang.cooking.service;

import com.chiendang.cooking.dto.request.InstructionRequest;
import com.chiendang.cooking.dto.response.InstructionResponse;

import java.util.List;

public interface InstructionService {
    List<InstructionResponse> saveAllInstruction(List<InstructionRequest> requests);
    List<InstructionResponse> findAllInstructionByRecipeId (Integer id);
}
