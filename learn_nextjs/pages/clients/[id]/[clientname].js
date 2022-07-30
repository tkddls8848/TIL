import { useRouter } from "next/router";

function IdWithClientPage() {
    const router = useRouter();

    return (
        <div>
            <h1>This is id + clientname</h1>
            <h2>{router.query.id}</h2>
            <h2>{router.query.clientname}</h2>
            <div>{router.query.message}</div>
        </div>
    );
};

export default IdWithClientPage;