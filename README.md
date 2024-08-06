# findatimeplease

You can play around with a deployed Flutter Web version here:

https://findatimeplease.web.app/

This is built to be viewed on a desktop computer. The scrolling functionality on mobile web is NOT optimized.

## Request Appointment

I took a simpler UX experience approach. It is a step by step sequence where the user selects a provider, selects a date, then selects a time, and then enters their information. This is a simple and easy to understand flow. The user can see the available times for the provider and can select a time that works for them.

### Incomplete Tasks

The format of the data that is sent to the backend is not considered. A middle translation layer would almost certainly be needed to convert the data to a format that the backend can understand.

## Set Provider Schedule

I took the approach of a provider setting their schedule either a week in advance. From a UX perspective, when I was working freelance, I would have a set schedule for the coming weeks, and if I needed to adjust my schedule, that would be handled on a case by case basis. In this current implementation, there is no option for a provider to set a schedule for a specific day. This could be a feature that is added in the future.

### Known Issues

There is no validation on if the start time is before the end time. File organization can be optimized. Unit, Widget, and Integration tests are needed.

### Incomplete Tasks

The format of the data that is sent to the backend is not considered. A middle translation layer would almost certainly be needed to convert the data to a format that the backend can understand.

\
