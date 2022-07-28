import { useRouter } from "next/router";

function ShowID() {
    const router = useRouter();

    return (
      <div>
        <h1>ID : { router.query.id }</h1>
      </div>
    );
  };
  
  export default ShowID;