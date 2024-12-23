package com.chiendang.cooking.controller;

import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.service.impl.InstructionServiceImpl;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/instructions")
public class InstructionController {
    private  final InstructionServiceImpl instructionService;

    public InstructionController(InstructionServiceImpl instructionService) {
        this.instructionService = instructionService;
    }

    @GetMapping("/{recipeId}")
    public ResponseData<?> findAllInstructionByRecipeId(@PathVariable int recipeId){
        return new ResponseData<>(HttpStatus.OK.value(), "Get all instrucion by recipeId =" + recipeId, instructionService.findAllInstructionByRecipeId(recipeId));
    }
}
