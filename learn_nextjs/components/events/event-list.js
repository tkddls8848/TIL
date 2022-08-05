import EventItem from "./events-item";

function EventList(props) {
    const { items } = props;

    return (
        <ul>
            {items.map((event) => (<EventItem 
                key={event.id}
                title={event.title} 
                image={event.image} 
                date={event.date} 
                location={event.location} 
                id={event.id} />
            ))}
        </ul>
    )
};

export default EventList;