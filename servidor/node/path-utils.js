const extractLastPathname = (url) => {
    return url.pathname.split('/').pop();
}

const hasPath = (path, paths) => {
    return paths.includes(path);
}

const notHasPath = (path, paths) => {
    return !hasPath(path, paths);
}

module.exports = {extractLastPathname, hasPath, notHasPath};