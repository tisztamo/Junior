export const getBaseUrl = () => {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const baseUrl = urlParams.get('baseUrl');

    return baseUrl || 'http://localhost:10101';
};
