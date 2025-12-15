import { render, screen } from '@testing-library/react';
import App from './App';

test('renders Octofit Tracker welcome message', () => {
  render(<App />);
  const welcomeElement = screen.getByRole('heading', { name: /Welcome to.*Octofit Tracker/i });
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
