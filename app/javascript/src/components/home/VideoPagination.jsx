import {Pagination} from "react-bootstrap";
import React, {useEffect, useMemo, useState} from "react";

const VideoPagination = ({ active, size = undefined, total, perPage, onChange }) => {
    const [maxPage, setMaxPage] = useState(Math.ceil(total / perPage));

    const items = useMemo(() => {
        console.log('maxPage', maxPage)
        const items = [];
        let middle = Math.ceil(maxPage / 2);
        if (maxPage >= 10 && active > 1 && active < maxPage - 2) {
            middle = active
        }

        // TODO: optimize logic with middle number

        for (let i = 0; i < maxPage; i++) {
            if (maxPage < 10 || i < 2 || (i > maxPage - 3) || (maxPage >= 10 && i > middle - 2 && i < middle + 2)) {
                items.push(i + 1);
            }
        }
        return [...new Set(items)];
    }, [maxPage, active])

    useEffect(() => {
        setMaxPage(Math.ceil(total / perPage))
    }, [total])

    const isShort = maxPage > 10
    return <Pagination size={size}>
        {isShort && <Pagination.First onClick={() => onChange(1)} disabled={active === 1}/>}
        {isShort && <Pagination.Prev onClick={() => onChange(active - 1)} disabled={active === 1}/>}
        {items.map((v, i, a) => {
            return <React.Fragment key={v} >
                <Pagination.Item active={v === active} onClick={() => onChange(v)}>
                    {v}
                </Pagination.Item>
                {i < a.length && a[i+1] - v > 1 && <Pagination.Ellipsis />}
            </React.Fragment>
        })}
        {isShort && <Pagination.Next onClick={() => onChange(active + 1)} disabled={active === total}/>}
        {isShort && <Pagination.Last onClick={() => onChange(total)} disabled={active === total}/>}
    </Pagination>
}

export default VideoPagination;