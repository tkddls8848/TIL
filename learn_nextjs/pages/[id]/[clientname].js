import { useRouter } from "next/router";

function idwithclientname() {
    const router = useRouter();
    console.log(router.query);
    return (
        <div>
            <h1>This is id + clientname</h1>
            <h2>{router.query.id}</h2>
            <h2>{router.query.clientname}</h2>
        </div>
    )
};

export default idwithclientname;