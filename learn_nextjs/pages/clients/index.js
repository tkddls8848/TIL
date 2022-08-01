import Link from "next/link";

function DynamicFolderPage() {
    const clients = [
        { id: "user1", name: "max"},
        { id: "user2", name: "manuel"}
    ]
 
    return (
      <div>
        <h1>This is ClientPage</h1>
        <ul>
          {clients.map((client) => (
            <li key={client.id}>
                <Link href={{
                    pathname: "/clients/[id]/[clientname]",
                    query: {id: client.id, clientname: client.name, message:"Welcome"}
                }}>{client.id}</Link>
            </li>
          ))}
        </ul>
      </div>
      )
    };

export default DynamicFolderPage;