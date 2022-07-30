import { useRouter } from "next/router";

function ClientPage() {
  const router = useRouter();
  const buttonHandler = () => {
    router.push({
      pathname: '/clients/[id]/[clientname]',
      query: {id: router.query.id, clientname: "test"}
    });
  };

  return (
      <div>
        <h1>This is Simple ClientPage</h1>
        <div>
          your user id is <b>{router.query.id}</b>
          <button onClick={buttonHandler}>
            Jump to info
          </button>
        </div>
      </div>
    );
  };
  
  export default ClientPage;