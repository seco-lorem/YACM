# YACM: Yet Another Club Manager
YACM is yet another club manager that is oriented on a social media-like structure for clubs in Bilkent to promote their events and reach out to their members.

### Instructions To Build The Software
Prerequisites: Flutter [Install](https://docs.flutter.dev/get-started/install) | Flutter, Git Bash (Windows) [Install](https://git-scm.com/downloads) \
In your preferred directory, run:
```
git clone https://github.com/seco-lorem/YACM
cd YACM
flutter pub get
flutter run -d chrome --no-sound-null-safety --web-renderer=html
```
You can choose to not type the -d chrome part of the command and instead, choose your preferred browser to open the application in by typing the corresponding integer in the console.\
\
YACM takes everyone in club processes into consideration and thus has 4 different user types. Viewers are people who can search and view events without a registration to YACM. Since the main goal of club managers in YACM is to be able to promote their club widely, we believe these types of users are necessary. Members are people who are logged in to the system and have the ability to declare participation in events, answer club polls, become members of clubs and some other things that are exclusive to people who are registered to YACM. Club Managers are people who have the authority to create, remove and modify forementioned events and polls, as well as manage members. Advisors are assigned to clubs by Bilkent, who are there to supervise a club. They have the authority to veto events created by Club Managers, on top of what Members of YACM have.\
YACM is beneficial for every type of person in the Bilkenter club ecosystem. People who are not initially interested in clubs of Bilkent can hear them through the use of YACM, since a log-in is not necessary to reach the information in the app. Bilkent users who have registered to YACM can have events of their interests presented to them through the system, pin events to check later if they’re unsure to join the event or to see the event details again, and can easily track the events they’re attending. YACM is useful for Club Managers to track participation to events, since there is currently no such system to pre-determine people who are joining events, except for say GE250/1 specific events. Currently, advisors on Bilkent need to manually reach out to Club Managers or they need to actively follow BAIS mails to see what their clubs are doing. YACM wants to change this and wants to step up the supervision by giving advisors the power to veto events that they deem inappropriate.

## Design Report

![Design Report](https://github.com/seco-lorem/YACM/tree/main/reports/Design_Report.pdf)

## Analysis Report

![Analysis Report](https://github.com/seco-lorem/YACM/tree/main/reports/Analysis_Report.pdf)
