# Application Structure and Maintenance

## The Structure

This application makes use of the Ruby on Rails web framework. This framework provides much of the underlying structure of the application. To learn about the structure of a Ruby on Rails application, please see the [Ruby on Rails documentation](http://guides.rubyonrails.org/getting_started.html#creating-the-blog-application).

### Custom Libraries

This application makes use of a couple of custom libraries. Their source can be found in the `lib` directory. These libraries are really the core of the application. They allow the grade and the LTI interaction work nicely.

### Sessions

With this application, sessions are not created by a user signing in. They are created via an LTI launch. If you need to alter the session handling functionality, you will need to look at both the `application`, and the `launch` controllers.

### The Grader

The grader is somewhat complex, a couple of systems must be working properly in order for it to do the same. These systems are Docker (and its API), and the job scheduler/runner. When working with the grader, a couple of files are of interest. First, the worker library, found in `lib/grader/worker.rb`. The worker contains functions to make working with the Docker container much easier for the application itself. The second file is the job file, which can be found in `app/jobs/grader_job.rb`. The job contains the code nessessary for grading to occurr.

### Learning Tools Interoperability

The Learning Tools Interoperability standard, is one which allows provider applications (like this one) to interact with consumer applications (like ELearning or Moodle). We have decided to make use of a Ruby gem implementing this standard. To learn more about this gem, take a look at its [GitHub page](https://github.com/instructure/ims-lti), to learn more about LTI itself, take a look at the [organization's website](https://www.imsglobal.org/activity/learning-tools-interoperability). The application makes use of the LTI gem at many stages, from creating the session, and all the way to submitting grades. For the most part, the following are those files making use of the library: `app/controller/launch_controller.rb` and `app/job/post_grade_job.rb`.

## Maintenance

Throughout development, we have made use of a number of tools to make our workflow simpler and more efficient. For instance, we use Git for version control. We also make use of Travis CI, so that we may be certain any new features/changes do not harm the existing application.

### Coding Standards

The coding standards for the application are fairly relaxed, however we do have a couple of requirements:

- Any CSS/SCSS should be written with [BEM](https://en.bem.info) in mind.
- Ruby/JavaScript code should make a decent use of white space between unrelated chunks of code.
- Function definitions should be written with a space between the function name, and the opening parenthesis of the argument list.
  - Function calls, however do not need, and should not have this space.

