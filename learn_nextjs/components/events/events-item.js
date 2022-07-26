import Link from "next/link";

function EventItem(props) {
    const { title, image, date, location, id } = props;

    const humanReadableDate = new Date(date).toLocaleDateString('en-US', {
        day: 'numeric',
        month: 'long',
        year: 'numeric',
    });
    const formattedAddress = location.replace(', ', '\n');
    const exploreLink = `/events/${id}`;
    return (
        <li>
            <img src={ "/" + image } alt={ title }></img>
            <div>{ "/" + image }</div>
            <div>
                <h2>{ title }</h2>                
                <div>
                    <time>{ humanReadableDate }</time>
                </div>
                <div>
                    <address>{ formattedAddress }</address>
                </div>
                <div>
                    <Link href={ exploreLink }>url</Link>
                </div>
            </div>
        </li>
    )
};

export default EventItem;