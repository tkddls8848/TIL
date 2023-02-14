import { getFeaturedEvents } from './dummy-data';
import EventList from '../components/events/event-list';

function HomePage() {
  const featuredEvents = getFeaturedEvents();

  return (
    <div>
      <h1>This is HomePage</h1>
      <EventList items={featuredEvents}/>
    </div>
  );
};

export default HomePage;