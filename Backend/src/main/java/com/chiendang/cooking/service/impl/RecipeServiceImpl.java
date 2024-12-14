package com.chiendang.cooking.service.impl;

import com.chiendang.cooking.api.auth.dto.response.UserResponse;
import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.auth.service.UserService;
import com.chiendang.cooking.entity.Image;
import com.chiendang.cooking.service.ImageService;
import com.chiendang.cooking.dto.request.RecipeRequest;
import com.chiendang.cooking.mapper.CategoryMapper;
import com.chiendang.cooking.entity.Ingredient;
import com.chiendang.cooking.mapper.IngredientMapper;
import com.chiendang.cooking.entity.Instruction;
import com.chiendang.cooking.mapper.InstructionMapper;
import com.chiendang.cooking.service.RecipeService;
import com.chiendang.cooking.utils.ImageType;
import com.chiendang.cooking.utils.PageResponse;
import com.chiendang.cooking.dto.response.RecipeResponse;
import com.chiendang.cooking.entity.Recipe;
import com.chiendang.cooking.mapper.RecipeMapper;
import com.chiendang.cooking.repository.RecipeRepository;
import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.exception.ErrorCode;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class RecipeServiceImpl implements RecipeService {

    RecipeRepository recipeRepository;
    RecipeMapper recipeMapper;
    InstructionMapper instructionMapper;
    IngredientMapper ingredientMapper;
    CategoryMapper categoryMapper;
    ImageService imageService;
    UserService userService;


    public RecipeResponse createNewRecipe(RecipeRequest request, MultipartFile file, Integer userId) throws IOException {
        User userCreated = userService.getUserById(userId)
                .orElseThrow(() ->new AppExceptions(ErrorCode.USER_NOT_EXISTED));

        List<Instruction> instructions = instructionMapper.toListInstruction(request.getInstructions());
        Set<Ingredient> ingredients = ingredientMapper.toListIngredient(request.getIngredients());

        Recipe recipe = Recipe.builder()
                .recipeName(request.getRecipeName())
                .category(request.getCategory())
                .cookTime(request.getCookTime())
                .prepTime(request.getPrepTime())
                .rating(request.getRating())
                .instructions(instructions)
                .ingredients(ingredients)
                .userCreated(userCreated)
                .build();

        Recipe recipeSaved = recipeRepository.save(recipe);

        Image image = imageService.createUserImage(file,recipeSaved.getId(), ImageType.RECIPE);

        recipeSaved.setImage(image.getImageUrl());

       return recipeMapper.toRecipeResponse(recipeRepository.save(recipeSaved));
    }

    public RecipeResponse getRecipe (Integer recipeId){
        Recipe recipe = this.getRecipeInfo(recipeId);
        return recipeMapper.toRecipeResponse(recipe);
    }

    public RecipeResponse updateRecipe(Integer id, RecipeRequest request, MultipartFile file) throws IOException {
        List<Instruction> instructions = instructionMapper.toListInstruction(request.getInstructions());
        Set<Ingredient> ingredients = ingredientMapper.toListIngredient(request.getIngredients());

        Image image = imageService.createUserImage(file,id,ImageType.RECIPE);

        Recipe recipe = recipeRepository.findByid(id);

        recipe.setImage(image.getImageUrl());
        recipe.setRecipeName(request.getRecipeName());
        recipe.setRating(request.getRating());
        recipe.setCookTime(request.getCookTime());
        recipe.setCategory(request.getCategory());
        recipe.setPrepTime(request.getPrepTime());
        recipe.getInstructions().clear();
        recipe.getInstructions().addAll(instructions);
        recipe.getIngredients().clear();
        recipe.getIngredients().addAll(ingredients);

        Recipe recipeUpdated=recipeRepository.save(recipe);

        return recipeMapper.toRecipeResponse(recipeUpdated);
    }

    @Override
    public List<RecipeResponse> getAllRecipe (){

        List<Recipe> recipes = recipeRepository.findAll();

        return recipes.stream().map(recipeMapper::toRecipeResponse).toList();
    }

    @Override
    public PageResponse<?> findRecipeByLimit (String name, long lastId , int limit) {
        List<Recipe> recipes;


        if(StringUtils.hasLength(name)){
            if (lastId == 0) {
                // Gọi lần đầu với lastId = 0
                recipes = recipeRepository.findRecipeByName(name,0L, limit);
            } else {
                // Lần sau, truyền lastId là id của bản ghi cuối cùng trong list
                recipes = recipeRepository.findRecipeByName(name,lastId, limit);
            }
        }else {
            if (lastId == 0) {
                // Gọi lần đầu với lastId = 0
                recipes = recipeRepository.findRecipesByIdGreaterThan(0L, limit);
            } else {
                // Lần sau, truyền lastId là id của bản ghi cuối cùng trong list
                recipes = recipeRepository.findRecipesByIdGreaterThan(lastId, limit);
            }

        }

        long newLastId = 0;  // Khởi tạo giá trị mặc định cho lastId
        if (recipes != null && !recipes.isEmpty()) {
            // Lấy ID của phần tử cuối cùng trong danh sách
            newLastId = recipes.get(recipes.size() - 1).getId();
        } else {
            throw new AppExceptions(ErrorCode.LIST_EMPTY);
        }

        List<RecipeResponse> recipeResponses = toRecipeResponse(recipes);

        return  PageResponse.builder()
                .lastElementId((int)newLastId)
                .items(recipeResponses)
                .build();

    }


    public Recipe getRecipeInfo( Integer recipeId){
         return recipeRepository.findById(recipeId)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));
    }

    public boolean existById(Integer recipeId){
        return !recipeRepository.existsById(recipeId);
    }

    public List<RecipeResponse> toRecipeResponse(List<Recipe> recipes){
        List<RecipeResponse> recipeResponses = new ArrayList<>();


        for (Recipe recipe:recipes){
            Set<Ingredient> ingredients = recipe.getIngredients();
            List<Instruction> instructions = recipe.getInstructions();


            RecipeResponse response = new RecipeResponse();
            response.setRecipeName(recipe.getRecipeName());
            response.setId(recipe.getId());
            response.setCategory(categoryMapper.toCategoryResponse(recipe.getCategory()));
            response.setUser(new UserResponse(recipe.getUserCreated().getFirstName(), recipe.getUserCreated().getLastName()));
            response.setImage(recipe.getImage());
            response.setCookTime(recipe.getCookTime());
            response.setPrepTime(recipe.getPrepTime());
            response.setIngredients(ingredientMapper.toListIngredientResponse(ingredients));
            response.setInstructions(instructions.stream().map(instructionMapper::toInstructionResponse).toList());
            recipeResponses.add(response);
        }
        return recipeResponses;
    }




}
