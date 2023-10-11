# Assessments

## Quizzes

Quizzes are a type of "episode" offered in a video course.
This walks you through how to add a quiz to your course if instructed to do so by the Video Team Lead.

### Assessments Directory

This directory would contain a yaml file per assessment (in this case quiz), named `##-quiz.yaml` where the ## is a zero-padded number. So a course with 5 quizzes would have 5 files: 01-quiz.yaml, 02-quiz.yaml etc.

### Quiz yaml

This contains all of the metadata necessary so that we can display the quiz on the site.
It contains a few familiar fields that are already required for video episodes and therefore are required for quizzes as well. `short_description` is no longer required, but would be valuable, if used thoughtfully, for SEO purposes.

You can find the required fields with explanations in the `00-quiztemplate.yaml` file.

### release.yaml

Quizzes need to be linked in the right position in the episode list of `publish.yaml`.
Quizzes go outside of the numbering of the episodes (as it is possible to have access to episodes but not quizzes), therefore a quiz should have a ref of **Q#**, where each quiz _needs_ to have a unique ref, and the number of the immediately following episode would continue the episode numbering sequence.

```yaml
  - title: "Quiz: Title"
    ref: "Q1"
    assessment_file: assessments/00-quiztemplate.yaml
```
