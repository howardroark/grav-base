### Install Complete!

Grav is now running at `http://{{ droplet.ip }}`.

#### DNS

Point your domain's A record towards `{{ droplet.ip }}` at any time.

#### Development & Deployment

Clone the project from the droplet:

```
git clone grav-base@{{ droplet.ip }}:/project.git
```

Once in your project's directory you can run `vagrant up`

Any changes you push to the `master` branch will automatically be deployed and,
any changes made in the Grav admin panel will be available to pull.
