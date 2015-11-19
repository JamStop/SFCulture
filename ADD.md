# SFCulture APP

##Objective
SFCulture is a more direct way for people in their regions to interact and participate with their respective cultures. Despite the movement of diversity in this globalized world, individualized culture still plays a powerful role in interpersonal interactions and the construction of community, and is an organic part of human nature. At the moment, the closest thing to digitalized cultural interaction is at the level of Facebook pages (i.e. Egyptians in SF, Chinese in Boston, etc.) and the like, which ultimately provides an experience that is anchored on the surface level, with very little incentive for an interactive community. SFCulture provides a platform solely dedicated to reaching out and being a part of the community in your area, bypassing the barriers present in general social networks and specialized dating sites (which have a negative connotation and ultimately are not made for communities).

##Audience
Most, if not all, people have a distinct culture that they identify with. Whether it is race, religion, or common upbringings, people naturally have distinct attributes and an inclination to participate with others who match these general traits. The audience could be immigrants from others countries looking for their familiar communities in a new environment, in which SFCulture allows both an assimilation into a new society (which ultimately promotes globalization in the end), as well as a community to lean on. It also could be indivuals simply looking to connect, or even reconnect, with their heritage community, bringing culture both into their own lives, as well as inject a bit of culture into their region as a whole. At the moment, we are focusing this app on the SF/Bay Area region (which definitely needs some culture reinjection), but in theory there should not be an area that cannot benefit from this app.


##Experience
The MVP is simple, as we only need a clean way for the user to choose their community, browse through their peers, and ultimately connect with them. The app's design will be clean and flat, and will be as intuitive as possible.

The user opens with a series of info screens, which leads to the user signing in through Facebook. The user is then presented with culture selection screen (we will only offer a single culture per user at the moment, for onboarding purposes), and then is taken to a tab view controller with 3 tabs: Browse, chat, and profile. 

The experience overall should be minimal, and because the only action available to users is "chat", people are naturally forced to interact in a more personal form than if a news feed or the likes were available. 

The profile is linked to Facebook, but the user is given the option to choose their own photo (if they don't like the Facebook preloaded one), and can customize information about themselves. Some things like age, location, and some other traits are locked in, while others like tag line, hobbies, etc. are customizable.


##Technical

####External Services
Facebook SDK
Firebase (For chat service, temporary for now; we need to make own backend later)


####Screens
Splash Screen/Landing Screen
Info Screens
Login/Signup with Facebook Screen
Tab Bar
Browse people screen (popup with view profile and chat)
Profile screen (personal)
Profile screen (others)
Chats Screen
1 on 1 Chat Screen



####Views / View Controllers/ Classes
Onboard Page View Controller
Onboard View 1
Onboard View 2
Onboard View 3

Culture Selection View Controller
Culture Select View
Culture Add View

Login View Controller
Login View

Main Tab Bar View Controller
Browse View
Chats View
Chat View
Profile View
Other People Profile View

Custom Views
Other People Profile Icon View



####Data Models
User
Chat
Chats
Culture



##MVP Milestones (Generous time for everything in theory)
Week 1: Prep everything
Week 2: Prep and Login
Week 3: Login and server setup
Week 4: Server and custom views
Week 5: Views and tab bar
Week 6: Browse
Week 7: Chat
Week 8: Profile


