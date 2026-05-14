VAR missionDuration = 2.5
VAR playerShipName = "Voyager"
VAR playerShipId = 123
VAR npcShipId = 124
VAR conversationId = 67
VAR lastPath = -> rangerChat
EXTERNAL getLastPath()

Event: targeting.setTarget shipId: {playerShipId} targetId: {npcShipId} persist events.targetedRanger


-> rangerChat 

= rangerChat
Ranger: Captain, what do you think you're doin', barrelin' in here at high warp? My pants are all wet. # rangerIntro.ogg
* [Crew: Your pants?]
-> pants
* [Crew: We're here to take over for you.]
-> rangersMission

= pants
Ranger: Well I was sitting here, sipping my coffee, when I hear someone say that you've almost arrived. "Good" I say. "It's about time someone came to relieve us." But then you keep gettin' closer until you're almost on top of us, and you know what I did? Well, I spilled my coffee all over my pants. I hope you're happy. # rangerPants.ogg
-> rangersMission

= rangersMission
{pants:Ranger: I am glad you're here though. # rangerGladPants.ogg |  Ranger: I am glad you're here. # rangerGlad.ogg}

Ranger: This wormhole is a big deal. We need to make sure it has constant supervision, but we've got to get back to starbase. Once we're gone, we ain't coming back. # rangerWormhole.ogg

Action: objectives.add shipId: {playerShipId} title: Monitor Wormhole description: Keep an eye on the wormhole, attempt to discover where it leads and how it is so stable.

* [Crew: Do we have any support?]
-> montgomeryIsHere
* {missionDuration < 4} [Crew: What about the damaged ship?]
-> roolsShip
* [Crew: Understood]
-> rangerGoodbye

= montgomeryIsHere
Ranger: You've got the Montgomery. They're a small science ship studying the nebula over yonder. We would have them come watch the wormhole too, but they've got no firepower to speak of, just in case something nasty comes crawling out of it. # rangerMontgomery.ogg

Action: objectives.add shipId: {playerShipId} title: Contact Montgomery description: Send a message to the Montgomery to let them know you are in the area.

* {not roolsShip} [Crew: What about the damaged ship?]
-> roolsShip
* [Crew: Understood]
-> rangerGoodbye

= roolsShip
Ranger: It's the darndest thing. One second there was nothing, the next that ship comes barreling out of the wormhole. Someone calls us on the radio askin' for political asylum - I'm no diplomat so I had to look that one up. They're a refugee and want us to protect them. It sounds like you have the power to grant political asylum, so I'll leave it to you to decide whether to let them stay, or to send them back where they came from. # rangerRool.ogg

Action: objectives.add shipId: {playerShipId} title: Decide whether to give the refugee political asylum.


* {not montgomeryIsHere} [Crew: Do we have any support?]
-> montgomeryIsHere
* [Crew: Understood]
-> rangerGoodbye

= rangerGoodbye
Ranger: We'll be going now. Remember,{missionDuration < 4: decide whether to give asylum to that critter over there, and} if you need any help, give the Montgomery a call. Ranger out. {missionDuration < 4: # rangerGoodbyeWithRool.ogg | # rangerGoodbye.ogg}

Action: shortRangeComm.disconnectConversation conversationId: {conversationId}

-> DONE


=== events

= targetedRanger

~ lastPath = getLastPath()

Event: targeting.setTarget shipId: {playerShipId} targetId: null events.clearedTarget

// Branch the conversation based on how many times the crew has targeted the Ranger.
{
    - targetedRanger > 2: 
    Ranger: I'm getting really tired of you targeting my ship. Have you got a discipline problem over there? # rangerTarget3.ogg
    - targetedRanger > 1: 
    Ranger: Again? Really, Captain, I need you to stop targeting my ship. # rangerTarget2.ogg
    - else:
    Ranger: Captain, what the devil do you think you're doin'? Stop targeting my ship right now! # rangerTarget1.ogg
}

// New event listener for when the Ranger is un-targeted.

* [Wait for event]

= clearedTarget


Ranger: That's more like it. As I was saying... # rangerTargetCleared.ogg

// Reactivate the event in case the crew targets the Ranger again.
Event: targeting.setTarget shipId: {playerShipId} targetId: {npcShipId} persist events.targetedRanger 

-> lastPath
