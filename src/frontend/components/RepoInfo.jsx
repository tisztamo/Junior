import { createSignal, onCleanup } from 'solid-js';

const RepoInfo = () => {
    const [repoInfo, setRepoInfo] = createSignal({});

    // Fetch the repo info on component mount and set it to state
    const fetchRepoInfo = async () => {
        const response = await fetch('/git/repoinfo');
        const data = await response.json();
        setRepoInfo(data);
    }

    fetchRepoInfo();

    return (
        <span class="text-sm font-mono bg-gray-200 dark:bg-gray-700 px-1 py-0.5 mt-2 rounded">
            {repoInfo().name} {repoInfo().branch}
        </span>
    );
};

export default RepoInfo;
