package com.chiendang.cooking.api.instruction.service;

import com.chiendang.cooking.api.instruction.dto.InstructionRequest;
import com.chiendang.cooking.api.instruction.dto.InstructionResponse;
import com.chiendang.cooking.api.instruction.entity.Instruction;
import com.chiendang.cooking.api.instruction.repository.InstructionRepository;
import com.chiendang.cooking.api.recipe.mapper.RecipeMapper;
import com.chiendang.cooking.api.recipe.service.RecipeService;
import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.exception.ErrorCode;
import org.springframework.stereotype.Service;

@Service
public class InstructionService {
    InstructionRepository instructionRepository;
    RecipeMapper recipeMapper;
    RecipeService recipeService;

    public InstructionResponse addInstruction(InstructionRequest request){


        Instruction instruction = Instruction.builder()
                .stepNumber(request.getStepNumber())
                .description(request.getDescription())
                .build();

        Instruction saved = instructionRepository.save(instruction);


        return InstructionResponse.builder()
                .id(saved.getId())
                .stepNumber(saved.getStepNumber())
                .description(saved.getDescription())
                .recipeId(recipeMapper.toRecipeResponse(saved.getRecipeId()))
                .build();
    }

    public InstructionResponse updateInstruction(Integer id, InstructionRequest request){
        if(instructionRepository.existsById(id)){
            throw new  AppExceptions(ErrorCode.RESOURCES_NOT_FOUND);
        }

        Instruction instruction = Instruction.builder()
                .stepNumber(request.getStepNumber())
                .description(request.getDescription())
                .recipeId(recipeMapper.toRecipe(request.getRecipeId()))
                .build();


        instructionRepository.save(instruction);


        return InstructionResponse.builder()
                .id(instruction.getId())
                .stepNumber(instruction.getStepNumber())
                .description(instruction.getDescription())
                .recipeId(recipeMapper.toRecipeResponse(instruction.getRecipeId()))
                .build();

    }

    public void deleteInstruction (Integer id){
        Instruction instruction = instructionRepository.findById(id)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));
        instructionRepository.delete(instruction);
    }


}
