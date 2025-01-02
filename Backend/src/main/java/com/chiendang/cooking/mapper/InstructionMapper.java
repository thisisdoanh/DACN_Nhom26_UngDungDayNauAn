package com.chiendang.cooking.mapper;

import com.chiendang.cooking.dto.request.InstructionRequest;
import com.chiendang.cooking.dto.response.InstructionResponse;
import com.chiendang.cooking.entity.Instruction;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;


@Component
public class InstructionMapper {
    public Instruction toInstruction (InstructionRequest request){
        if (request == null){
            return null;
        }else {
            Instruction.InstructionBuilder instruction = Instruction.builder();
            instruction.description(request.getDescription());
            instruction.stepNumber(request.getStepNumber());
            return instruction.build();
        }
    }

    public InstructionResponse toInstructionResponse(Instruction instruction) {
        if (instruction == null) {
            return null;
        } else {
            InstructionResponse.InstructionResponseBuilder instructionResponse = InstructionResponse.builder();
            instructionResponse.id(instruction.getId());
            instructionResponse.stepNumber(instruction.getStepNumber());
            instructionResponse.description(instruction.getDescription());

            return instructionResponse.build();
        }
    }

    public List<InstructionResponse> toListInstructionResponse(List<Instruction> list){
        return list.stream().map(this::toInstructionResponse).collect(Collectors.toList());
    }
    public List<Instruction> toListInstruction (List<InstructionRequest> requests){
        return requests.stream().map(this::toInstruction).collect(Collectors.toList());
    }

}
