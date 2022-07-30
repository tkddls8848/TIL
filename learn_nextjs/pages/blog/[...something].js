import { useRouter } from "next/router";

function BlogPage() {
    const router = useRouter();
    console.log(router.query);
    
    return (
        <div>
            <h1>BlogPage</h1>
            <h2>{router.query.something}</h2>
        </div>
    );
};

export default BlogPage;