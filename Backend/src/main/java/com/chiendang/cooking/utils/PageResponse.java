package com.chiendang.cooking.utils;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class PageResponse<T> {

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private int lastElementId;
    private T items;
}
