# findatimeplease

A new Flutter project.

## Thoughts and Ruminations

In hindsight, I should have not attempted to squeeze in a coding challenge when on a road trip with a 5 month old to a wedding. I was not able to give this project the time and attention it deserved. I was able to get the basic functionality working, but I was not able to implement the more advanced features I wanted to.

In hindsight, I assumed the backend data structure for how schedules are set for providers. In a real world scneario, I would be in communication with the backend teams about database schema and business requirements. In this coding example, I made the assumption that the provider would have a list of available times and the user would select from those times.

With this implementation, if a provider needed to adjust their schedule, they would need to update the list of available times. This could be cumbersome if the provider has a schedule that changes weekly. On the contrary, if a provider is required to set their schedule each week, the user experience for the provider would be a little more painful.

A translation layer would most likely be needed.

Working with people and talking through solutions together would drastically change the workflow and implementation. I would have loved to have a conversation with the backend team to understand how the data is structured and how the data is used. This would have helped me understand the problem better and provide a more robust solution.

The number of decisions that need to be made in a feature like this is staggering. I would love the experience to talk through these decisions with a team and come to a consensus on the best solution.
