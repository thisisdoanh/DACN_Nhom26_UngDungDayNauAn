package com.chiendang.cooking.utils;

import lombok.Builder;

@Builder
public record MailBody(String to, String subject, String text ) {
}
