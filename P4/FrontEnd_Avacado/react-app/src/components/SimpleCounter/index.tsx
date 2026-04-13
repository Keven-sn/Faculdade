import { useState } from "react";

const SimpleCounter = () => {
    const [count, setCount] = useState<number>(2591);

    const handlePlus = () => {
        setCount(count + 1)
    }

    const handleMinus = () => {
        setCount(count - 1)
    }

    return (
        <div>
            <h1>{count}</h1>
            <div>
                <button onClick={handleMinus}>-</button>
                <button onClick={handlePlus}>+</button>
            </div>
        </div>
    )
}

export default SimpleCounter;