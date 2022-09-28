const workChrome = {
  name: 'Google Chrome',
  profile: 'Profile 2',
};

const personalChrome = {
  name: 'Google Chrome',
  profile: 'Default',
};

module.exports = {
  options: {
    hideIcon: true,
  },
  defaultBrowser: 'Google Chrome',
  handlers: [
    {
      match: ({ opener }) => {
        return opener.name === 'Tweetbot';
      },
      browser: personalChrome,
    },
    {
      match: ({ opener }) => {
        return opener.name === 'Slack';
      },
      browser: workChrome,
    },
    {
      match: /datad[o0]g/i,
      browser: workChrome,
    },
    {
      match: 'https://mail.google.com/mail/u/0/#starred?dd',
      browser: workChrome,
    },
    {
      match: 'https://mail.google.com/mail/u/0/#starred?me',
      browser: personalChrome,
    },
  ],
};
