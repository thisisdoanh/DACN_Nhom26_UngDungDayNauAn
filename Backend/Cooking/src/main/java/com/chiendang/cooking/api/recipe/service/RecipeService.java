package com.chiendang.cooking.api.recipe.service;

import com.chiendang.cooking.api.auth.dto.response.UserResponse;
import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.auth.repository.UserRespository;
import com.chiendang.cooking.api.auth.service.UserService;
import com.chiendang.cooking.api.ingredient.service.IngredientService;
import com.chiendang.cooking.api.instruction.service.InstructionService;
import com.chiendang.cooking.api.recipe.dto.request.RecipeRequest;
import com.chiendang.cooking.api.recipe.dto.response.RecipeResponse;
import com.chiendang.cooking.api.recipe.entity.Recipe;
import com.chiendang.cooking.api.recipe.mapper.RecipeMapper;
import com.chiendang.cooking.api.recipe.respository.RecipeRepository;
import com.chiendang.cooking.api.image.service.ImageService;
import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.exception.ErrorCode;
import jakarta.transaction.Transactional;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class RecipeService {

    RecipeRepository recipeRepository;
    UserRespository userRespository;
    IngredientService ingredientService;
    InstructionService instructionService;
    ImageService fileService;
    RecipeMapper recipeMapper;

    @NonFinal
    @Value("${project.foodimage}")
    String path;

    @NonFinal
    @Value("${base.url}")
    String baseUrl;

    @Transactional
    public RecipeResponse addRecipe(RecipeRequest request, MultipartFile file) throws IOException {
        if (Files.exists(Paths.get(path + File.separator + file.getOriginalFilename()))){
            throw  new AppExceptions(ErrorCode.FILE_IS_EXISTED);
        }
        String uploadedFileName = fileService.uploadFile(path,file);
        //2. set the value of field 'poster' as filename
        request.setImage(uploadedFileName);
        // lay thong tin nguoi dung hien tai
        var context = SecurityContextHolder.getContext();
        String name= context.getAuthentication().getName();
        User user = userRespository.findByEmail(name)
                .orElseThrow(() -> new AppExceptions(ErrorCode.USER_NOT_EXISTED));

        Recipe recipe = Recipe.builder()
                .recipeName(request.getRecipeName())
                .prepTime(request.getPrepTime())
                .cookTime(request.getCookTime())
                .category(request.getCategory())
                .user(user)
                .build();

        Recipe savedRecipe =  recipeRepository.save(recipe);
        try{
            request.getIngredients().forEach(ingredientService::addIngredient);
            request.getInstructions().forEach(instructionService::addInstruction);
        } catch (Exception e) {
            throw new RuntimeException("Error saving recipe details", e);
        }



        String imageUrl = baseUrl + "/file/" +uploadedFileName;

        RecipeResponse recipeResponse = recipeMapper.toRecipeResponse(savedRecipe);

        recipeResponse.setImageUrl(imageUrl);

        return  recipeResponse;
    }

    public RecipeResponse getRecipe (Integer recipeId){
        Recipe recipe = this.getRecipeInfo(recipeId);

        String imageUrl = baseUrl + "/file/" + recipe.getImage();

        RecipeResponse recipeResponse = recipeMapper.toRecipeResponse(recipe);
        recipeResponse.setImageUrl(imageUrl);

        return recipeResponse;
    }

    public RecipeResponse updateRecipe(Integer id, RecipeRequest request, MultipartFile file) throws IOException {
        Recipe recipe = recipeRepository.findById(id)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));

        String fileName = recipe.getImage();
        if (file != null){
            // xoa file lien quan
            Files.deleteIfExists(Paths.get(path + File.separator +recipe.getImage() ));
            if (Files.exists(Paths.get(path + File.separator + file.getOriginalFilename()))){
                throw  new AppExceptions(ErrorCode.FILE_IS_EXISTED);
            }
            fileName=fileService.uploadFile(path,file);
        }

        request.setImage(fileName);

        Recipe recipeUpdate = recipeMapper.toRecipe(request);

        recipeRepository.save(recipeUpdate);

        String imageUrl = baseUrl + "/file/" + fileName;

        RecipeResponse recipeResponse = recipeMapper.toRecipeResponse(recipeUpdate);

        recipeResponse.setImageUrl(imageUrl);

        return  recipeResponse;

    }

    public List<RecipeResponse> getAllRecipe (){

        List<Recipe> recipes = recipeRepository.findAll();

        return recipeMapper.toRecipeResponseList(recipes);
    }


     Recipe getRecipeInfo( Integer recipeId){
         return recipeRepository.findById(recipeId)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));
    }

    public boolean existById(Integer recipeId){
        return !recipeRepository.existsById(recipeId);
    }

    public List<RecipeResponse> searchRecipe(String search){
        return recipeRepository.findAllRecipeWithKey(search);
    }


}
