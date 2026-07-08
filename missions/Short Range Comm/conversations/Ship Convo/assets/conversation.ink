VAR conversationId = 67

-> shipChat

= shipChat
Ship: Greetings!
* [Crew: Nice to meet you.]
-> greeting

= greeting
Ship: Likewise! 

-> complete

= complete

Ship: Well, that's all for now. Have a good training!

Action: shortRangeComm.disconnectConversation conversationId: {conversationId}

-> DONE

