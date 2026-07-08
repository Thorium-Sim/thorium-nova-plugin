VAR conversationId = 67

-> shipChat

= shipChat
Earth: Hello there! I'm so glad you were able to call us as part of your training.
* [Crew: Nice to meet you.]
-> greeting
* [Crew: Hi there, training ship!]
-> flatter

= greeting
Earth: Likewise! 

-> complete

= complete

Earth: Well, that's all for now. Have a good training!

Action: shortRangeComm.disconnectConversation conversationId: {conversationId}

-> DONE

= flatter

Earth: Aww, flattery will get you nowhere.

-> complete

