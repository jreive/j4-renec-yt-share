export function delay(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
}

export function fetcher(url, payload, method = 'GET') {
    return fetch(url + (method === 'GET' ? '?' + new URLSearchParams(payload).toString() : ''), {
        method,
        headers: {
            'Accept': 'application/json',
            "Content-Type": 'application/json'
        },
        redirect: "follow",
        credentials: 'include',
        body: method === 'POST' ? JSON.stringify(payload) : undefined
    })
}

export const debounce = (func, delay) => {
    let timer;
    return (...arg) => {
        if (timer) clearTimeout(timer);
        timer = setTimeout(() => {
            func(...arg);
        }, delay);
    };
};