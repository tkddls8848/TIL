import { useRouter } from "next/router";

function ClientPage() {
  const router = useRouter();

  return (
      <div>
        <h1>This is Simple ClientPage</h1>
        <div>
          your user id is <b>{router.query.id}</b>
        </div>
      </div>
    );
  };
  
  export default ClientPage;