package com.side.mvcshop.user;


public class MessageDto {
    private String to;
//    String content; ==> ������ ���ڸ޽��� ������ ���.

    public MessageDto() {

    }

    public MessageDto(String to) {
    	this.to = to;
    }

    public String getTo() {
    	return to;
    }

    @Override
    public String toString() {
    	return "MessageDto {" +
    		   "to = '" + to + '\'' +
    		   '}';
    }
}
