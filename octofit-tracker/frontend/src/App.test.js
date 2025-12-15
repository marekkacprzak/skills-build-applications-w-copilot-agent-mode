import { render, screen } from '@testing-library/react';
import App from './App';

test('renders Octofit Tracker welcome message', () => {
  render(<App />);
  const welcomeElement = screen.getByText((content, element) => {
    return element?.tagName.toLowerCase() === 'h1' && content.includes('Welcome to') && element.textContent?.includes('Octofit Tracker');
  });
  expect(welcomeElement).toBeInTheDocument();
});

test('renders navigation links', () => {
  render(<App />);
  const activitiesLink = screen.getByText('Activities');
  const leaderboardLink = screen.getByText('Leaderboard');
  const teamsLink = screen.getByText('Teams');
  const usersLink = screen.getByText('Users');
  const workoutsLink = screen.getByText('Workouts');
  
  expect(activitiesLink).toBeInTheDocument();
  expect(leaderboardLink).toBeInTheDocument();
  expect(teamsLink).toBeInTheDocument();
  expect(usersLink).toBeInTheDocument();
  expect(workoutsLink).toBeInTheDocument();
});
