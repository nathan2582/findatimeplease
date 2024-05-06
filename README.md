# findatimeplease

You can play around with a deployed Flutter Web version here:

https://findatimeplease.web.app/

## Request Appointment

I took a simpler UX experience approach. It is a step by step sequence where the user selects a provider, selects a date, then selects a time, and then enters their information. This is a simple and easy to understand flow. The user can see the available times for the provider and can select a time that works for them.

# Note

This is built to be viewed on a desktop computer. The scrolling functionality on mobile web is NOT optimized. Scrolling is a bit janky on mobile web.

### Incomplete Tasks

The format of the data that is sent to the backend is not considered. A middle translation layer would almost certainly be needed to convert the data to a format that the backend can understand.

## Set Provider Schedule

I took the approach of a provider setting their schedule either a week in advance. From a UX perspective, when I was working freelance, I would have a set schedule for the coming weeks, and if I needed to adjust my schedule, that would be handled on a case by case basis. In this current implementation, there is no option for a provider to set a schedule for a specific day. This could be a feature that is added in the future.

### Known Issues

There is no validation on if the start time is before the end time.

### Incomplete Tasks

The format of the data that is sent to the backend is not considered. A middle translation layer would almost certainly be needed to convert the data to a format that the backend can understand.

# Thoughts and Ruminations

In hindsight, I should have not attempted to squeeze in a coding challenge when on a road trip with a 5 month old to a wedding. I was not able to give this project the time and attention it deserved. I was able to get the functionality working, but I was not able to implement the more advanced features I wanted to, I wasn't as organized as I would have liked.

My git commit history is far from what I desire. I would have liked to have more granular commits. I would have liked to have more descriptive commit messages. I would have liked to have actually utilized branches. I would have liked to have more tests. I would have liked to have more documentation.

I did spend about 6-7 somewhat distracted hours on this task. When not on vacation, I have a distraction-free workspace and work station.

I assumed the backend data structure for how schedules are set for providers. In a real world scneario, I would be in communication with the backend teams about database schema and business requirements. In this coding example, I made the assumption that the provider would have a list of available times and the user would select from those times.

With this implementation, if a provider needed to adjust their schedule, they would need to update the list of available times. This could be cumbersome if the provider has a schedule that changes weekly. On the contrary, if a provider is required to set their schedule each week, the user experience for the provider would be a little more painful.

A translation layer would most likely be needed.

Working with people and talking through solutions together would drastically change the workflow and implementation. I would have loved to have conversations with the dev teams to understand how the data is structured and how the data is used. This would have helped me understand the problem better and provide a more robust solution.

The number of decisions that need to be made in a feature like this is staggering. I would love the experience to talk through these decisions with a team and come to a consensus on the best solution.

The CountdownTimer needs some love.
