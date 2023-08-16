export const getBaseUrl = () => {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const baseUrl = urlParams.get('baseUrl');

    // Use the current protocol and host for the default baseUrl
    const defaultBaseUrl = `${window.location.protocol}//${window.location.hostname}:10101`;
    return baseUrl || defaultBaseUrl;
};
