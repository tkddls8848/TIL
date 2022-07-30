import {useRouter} from "next/router";

function ClientPage() {
    const router = useRouter();

    return (
      <div>
        <h1>This is ClientPage</h1>
        <div>
          Welcome <b>{router.query.id}</b> !
        </div>
      </div>
    );
  };
  
  export default ClientPage;