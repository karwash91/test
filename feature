// FeatureList.tsx
import React, { useEffect, useState } from 'react';
import { Feature } from './types';

const API_URL = 'http://localhost:4000/features';

const FeatureList: React.FC = () => {
  const [features, setFeatures] = useState<Feature[]>([]);

  useEffect(() => {
    fetch(API_URL)
      .then(res => res.json())
      .then(setFeatures);
  }, []);

  const upvote = async (feature: Feature) => {
    const updatedVotes = feature.votes + 1;

    await fetch(`${API_URL}/${feature.id}`, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ votes: updatedVotes })
    });

    setFeatures(features.map(f =>
      f.id === feature.id ? { ...f, votes: updatedVotes } : f
    ));
  };

  return (
    <div>
      <h2>Feature Voting</h2>
      <ul>
        {features.map(f => (
          <li key={f.id}>
            {f.name} — {f.votes} votes
            <button onClick={() => upvote(f)}>Upvote</button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default FeatureList;
