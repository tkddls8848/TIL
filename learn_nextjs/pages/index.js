import Link from "next/link";

function HomePage() {
  return (
    <div>
      <h1>This is HomePage</h1>
      <ul>
        <li>
          <a href="/portfolio">link through a tag</a>
        </li>
        <li>
          <Link href="/portfolio">link through Link tag</Link>
        </li>
      </ul>      
    </div>
  );
};

export default HomePage;